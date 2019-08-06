from typing import NamedTuple, List, Any

from plenum.common.messages.node_messages import CheckpointState, PrePrepare

# TODO: should be removed
ValidatorsChanged = NamedTuple('ValidatorsChange',
                               [('names', List[str])])

# TODO: should be removed
ParticipatingStatus = NamedTuple('LedgerParticipatingStatus',
                                 [('is_participating', bool)])

HookMessage = NamedTuple('HookMessage',
                         [('hook', int),
                          ('args', tuple)])

OutboxMessage = NamedTuple('OutboxMessage',
                           [('msg', Any)])

RequestPropagates = NamedTuple('RequestPropagates',
                               [('bad_requests', List)])

PrimariesBatchNeeded = NamedTuple('PrimariesBatchNeeded',
                                  [('pbn', bool)])

CurrentPrimaries = NamedTuple('CurrentPrimaries',
                              [('primaries', list)])

RevertUnorderedBatches = NamedTuple('RevertUnorderedBatches', [('inst_id', int)])

BackupSetupLastOrdered = NamedTuple('BackupSetupLastOrdered',
                                    [('inst_id', int)])

NeedMasterCatchup = NamedTuple('NeedMasterCatchup', [])

NeedBackupCatchup = NamedTuple('NeedBackupCatchup',
                               [('inst_id', int),
                                ('caught_up_till_3pc', tuple)])

CheckpointStabilized = NamedTuple('CheckpointStabilized',
                                  [('inst_id', int),
                                   ('last_stable_3pc', tuple)])
