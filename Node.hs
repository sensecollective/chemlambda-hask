module Node where

import qualified Data.List as L
import Atom
import Port

data Node a = Node 
  { atom  :: Atom
  , ports :: [Port a] }
  deriving ( Ord, Eq )

instance Show a => Show (Node a) where
  show (Node a ps) = "Node " ++ show a ++ " " ++ show ps

-- Constructors
lam :: a -> a -> a -> Node a
lam a b c = Node L [Mi a, Lo b, Ro c]

fo :: a -> a -> a -> Node a
fo a b c = Node FO [Mi a, Lo b, Ro c]

foe :: a -> a -> a -> Node a
foe a b c = Node FOE [Mi a, Lo b, Ro c]

app :: a -> a -> a -> Node a
app a b c = Node A [Li a, Ri b, Mo c]

fi :: a -> a -> a -> Node a
fi a b c = Node FI [Li a, Ri b, Mo c]

arrow :: a -> a -> Node a
arrow a b = Node ARROW [Mi a, Mo b]

frin :: a -> Node a
frin a = Node FRIN [Mo a] 

frout :: a -> Node a
frout a = Node FROUT [Mi a]

t :: a -> Node a
t a = Node T [Mi a] 

-- Selectors
liPort :: Node a -> Maybe (Port a)
liPort n = L.find isLi $ ports n 

riPort :: Node a -> Maybe (Port a)
riPort n = L.find isRi $ ports n

miPort :: Node a -> Maybe (Port a)
miPort n = L.find isMi $ ports n

loPort :: Node a -> Maybe (Port a)
loPort n = L.find isLo $ ports n

roPort :: Node a -> Maybe (Port a)
roPort n = L.find isRo $ ports n

moPort :: Node a -> Maybe (Port a)
moPort n = L.find isMo $ ports n


hasPortId :: (Eq a) => Node a -> a -> Bool
hasPortId n i = elem i (map portId $ ports n)
